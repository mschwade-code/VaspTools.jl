incar = read_incar(test_file_path*"INCAR")

@testset "INCAR read" begin
    @test get_value_for_keyword("ENCUT", incar) == "250"
    @test length(incar) == 5
    @test get_value_for_keyword("NCORE", incar) == "12"
    @test get_value_for_keyword("ISIF", incar) == "2"
    @test get_value_for_keyword("LPLANE", incar) == "True"
    @test get_value_for_keyword("LSCALAPACK", incar) == ".FALSE."
end

write_incar(incar, test_file_path*"INCAR_new")

incar_new = read_incar(test_file_path*"INCAR_new")
@testset "INCAR write" begin
    @test get_value_for_keyword("ENCUT", incar_new) == "250"
    @test length(incar_new) == 5
    @test get_value_for_keyword("NCORE", incar_new) == "12"
    @test get_value_for_keyword("ISIF", incar_new) == "2"
    @test get_value_for_keyword("LPLANE", incar_new) == "True"
    @test get_value_for_keyword("LSCALAPACK", incar_new) == ".FALSE."
end

keywords = ["EDIFF", "POTIM", "LCHARG", "NWRITE"]
values = ["1e-6", "10", "True", "1"]

@testset "INCAR change" begin
    for (keyword, value) in zip(keywords, values)
        set_keyword!(keyword, value, incar)
        @test get_value_for_keyword(keyword, incar) == value
    end
    write_incar(incar, test_file_path*"INCAR_prime")
    incar_prime = read_incar(test_file_path*"INCAR_prime")
    for (keyword, value) in zip(keywords, values)
        @test get_value_for_keyword(keyword, incar) == value
    end
end

rm(test_file_path*"INCAR_new")
rm(test_file_path*"INCAR_prime")