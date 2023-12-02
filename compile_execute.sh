#! /bin/bash


object_file_name_allocate='InttoString.o'
assembly_name_allocate='InttoString.s'

final_executable="InttoString"
echo
echo '[ASSEMBLY_SimpleTypeConversion : Integer to String]'
echo 
echo 'Transforming Integer to String in assembly code.'
echo 
echo '==================================================='
as -g -o ${object_file_name_allocate} ${assembly_name_allocate}
ld ${object_file_name_allocate} -o ${final_executable} 
echo
echo 'IntToString Executable created : OK'
echo 
echo '=====================Execution====================='
echo 
echo "Results:" 
./${final_executable}
echo
echo "It should be:7654321"
