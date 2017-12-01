using Helpers
using Base.Test

@testset "Generic" begin
    M = rand(10,10)
    ci = M[:,3]
    cj = M[:,5]
    swap_cols!(M,3,5)
    @test M[:,5] == ci
    @test M[:,3] == cj
    swap_cols!(M,3,5)
    @test M[:,3] == ci
    @test M[:,5] == cj

    ri = M[3,:]
    rj = M[5,:]
    swap_rows!(M,3,5)
    @test M[5,:] == ri
    @test M[3,:] == rj
    swap_rows!(M,3,5)
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
    @test docommute(diagm(rand(100)), diagm(rand(100)))
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