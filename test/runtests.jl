using Helpers
using Test, SparseArrays, LinearAlgebra, Statistics


@testset "All Tests" begin


@testset "Generic" begin
    M = rand(10,9)
    ci = M[:,3]
    cj = M[:,5]
    swapcols!(M,3,5)
    @test M[:,5] == ci
    @test M[:,3] == cj
    swapcols!(M,3,5)
    @test M[:,3] == ci
    @test M[:,5] == cj

    ri = M[3,:]
    rj = M[5,:]
    swaprows!(M,3,5)
    @test M[5,:] == ri
    @test M[3,:] == rj
    swaprows!(M,3,5)
    @test M[3,:] == ri
    @test M[5,:] == rj
end

@testset "Math" begin
    M = spzeros(100,100)
    for k in 1:250
        pos = rand(1:100,2)
        while M[pos...]!=0
            pos = rand(1:100,2)
        end
        M[pos...] = rand()
    end
    @test sparsity(M) == 0.975     
    
    # origSTDOUT = STDOUT
    # (outRead, outWrite) = redirect_stdout()
    @test isapprox(reldiff([1.0,3.4,0],[4,8,10]), [1.2, 0.8070175438596491, 2.0])
    @test isapprox(absdiff([1.0,3.4,0],[4,8,10]), [3.0, 4.6, 10.0])
    @test isapprox(effreldiff([1.0,3.4,0],[4,8,0]),  [1.2, 0.8070175438596491, 0.0])
    @test compare([1,2,3],[1,2,3]) == true
    @test compare([1,2,4],[1,2,3]) == false
    @test compare_full([1,2,3],[1,2,3]) == true
    @test compare_full([1,2,4],[1,2,3]) == false
    # close(outWrite)
    # data = readavailable(outRead)
    # close(outRead)
    # redirect_stdout(origSTDOUT)

    A = reshape(1:9,3,3)
    B = reshape(11:19,3,3)
    @test comm(A,B) == [60 -30 -120; 90 0 -90; 120 30 -60]
    @test docommute(diagm(0 => rand(100)), diagm(0 => rand(100)))
    @test !docommute(rand(100,100), rand(100,100))

    @test meshgrid(1:3,2:4) == ([1 2 3; 1 2 3; 1 2 3], [2 2 2; 3 3 3; 4 4 4])
    @test meshgrid(1:3) == ([1 2 3; 1 2 3; 1 2 3], [1 1 1; 2 2 2; 3 3 3])

    # TODO: Julia <-> Python sparse matrices tests
end

@testset "Random Generator save/restore" begin
    mktempdir() do path
        cd(path) do
            saverng("rng_test.h5")
            x = rand(100) # remember random numbers
            restorerng("rng_test.h5")
            @test rand(100) == x
            rng = loadrng("rng_test.h5")
            @test rand(rng, 100) == x
            setrng(loadrng("rng_test.h5"))
            @test rand(100) == x
        end
    end
end




@testset "Combined Mean and Variance" begin

    @testset "Two samples" begin
        test_two = (x1,x2) -> begin
            xc = vcat(x1,x2)
            meanc, varc = combined_mean_and_var(x1,x2)
            @test abs(mean(xc) - meanc) < 1e-12
            @test abs(var(xc) - varc) < 1e-12
        end

        x1 = rand(30_000)
        x2 = rand(20_000)
        test_two(x1,x2)

        x1 = rand(ComplexF64, 30_000)
        x2 = rand(ComplexF64, 20_000)
        test_two(x1,x2)
    end


    @testset "Three samples" begin
        test_three = (x1,x2,x3) -> begin
            xc = vcat(x1,x2,x3)
            meanc, varc = combined_mean_and_var(x1,x2,x3)
            @test abs(mean(xc) - meanc) < 1e-12
            @test abs(var(xc) - varc) < 1e-12

            meanc_three, varc_three = Helpers.combined_mean_and_var_three(x1,x2,x3)
            @test isapprox(meanc, meanc_three)
            @test isapprox(varc, varc_three)
        end

        x1 = rand(30_000)
        x2 = rand(20_000)
        x3 = rand(40_000)
        test_three(x1, x2, x3)

        x1 = rand(ComplexF64, 30_000)
        x2 = rand(ComplexF64, 20_000)
        x3 = rand(ComplexF64, 40_000)
        test_three(x1, x2, x3)
    end


    @testset "N samples" begin
        test_N = (xs...) -> begin
            xc = vcat(xs...)
            meanc, varc = combined_mean_and_var(xs...)
            @test abs(mean(xc) - meanc) < 1e-12
            @test abs(var(xc) - varc) < 1e-12
        end

        lengths = [30_000, 20_000, 40_000]
        N = 5

        xs = [rand(Float64, rand(lengths)) for _ in 1:N]
        test_N(xs...)

        xs = [rand(ComplexF64, rand(lengths)) for _ in 1:N]
        test_N(xs...)
    end


    @testset "N samples (ns, μs, vs)" begin
        test_N_moments = (ns, μs, vs, mean_exact, var_exact) -> begin
            meanc, varc = combined_mean_and_var(ns, μs, vs)
            @test abs(mean_exact - meanc) < 1e-12
            @test abs(var_exact - varc) < 1e-12
        end

        lengths = [30_000, 20_000, 40_000]
        N = 5

        xs = [rand(Float64, rand(lengths)) for _ in 1:N]
        xc = vcat(xs...)
        test_N_moments(length.(xs), mean.(xs), var.(xs), mean(xc), var(xc))

        xs = [rand(ComplexF64, rand(lengths)) for _ in 1:N]
        xc = vcat(xs...)
        test_N_moments(length.(xs), mean.(xs), var.(xs), mean(xc), var(xc))
    end
end


end # all tests