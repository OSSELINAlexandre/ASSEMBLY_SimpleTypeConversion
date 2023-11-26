#! /bin/bash


object_file_name_allocate='InttoString.o'
assembly_name_allocate='InttoString.s'

final_executable="InttoString"
echo
echo '[ASSEMBLY_SimpleTypeConversion : integer to string]'
echo 
echo 'Transforming integer to string in assembly code.'
echo 
echo '==================================='
as -g -o ${object_file_name_allocate} ${assembly_name_allocate}
ld ${object_file_name_allocate} -o ${final_executable} 
echo
echo 'Writing Executable created : OK'
echo 
echo 
echo '=============Execution============='
echo 
echo "Results:" 
./${final_executable}
echo
echo "It should be:7654321"
