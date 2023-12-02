#! /bin/bash


object_file_name_string_to_int='StringToIntToString.o'
assembly_name_string_to_int='StringToIntToString.s'

object_file_name_int_to_string='InttoString_global.o'
assembly_name_int_to_string='InttoString_global.s'


object_file_name_power='power.o'
assembly_name_power='power.s'

final_executable="StringToInt"
echo
echo '[ASSEMBLY_SimpleTypeConversion : String to Integer to String]'
echo 
echo 'Transforming String to Integer to String in assembly code.'
echo 
echo '============================================================='
as -g -o ${object_file_name_string_to_int} ${assembly_name_string_to_int}

as -g -o ${object_file_name_int_to_string} ${assembly_name_int_to_string}

as -g -o ${object_file_name_power} ${assembly_name_power}

ld ${object_file_name_string_to_int} ${object_file_name_int_to_string} ${object_file_name_power} -o ${final_executable} 
echo
echo 'StringToInt Executable created : OK'
echo
echo 'You can now execute StringToInt'
