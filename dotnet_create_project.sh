#!/bin/bash

project_name=$1
solution_name=$1
project_type=$2
use_auth=$3

print_usage() {
    local message=$'Usage: ./dotnet_project_creation.sh --name=[PROJECT_NAME] type=[PROJECT_TYPE] --use-auth=[true/false] (The default auth is Individual).\nEg: ./dotnet_project_creation.sh Test webapi false'
    echo "$message"
}

create_project_directory() {
    mkdir $project_name
}

create_directories() {
    mkdir src
    mkdir tests
    mkdir docs
}

create_sln() {
    dotnet new sln --name $project_name
}

start_git() {
    git init
}

create_gitignore() {
    dotnet new gitignore
}

create_readme() {
    echo "#$project_name" > README.md
}

attach_projects_to_sln() {
    dotnet sln add src/$project_name/$project_name.csproj
    dotnet sln add tests/$project_name.UnitTests/$project_name.UnitTests.csproj
}

create_main_project() {
    dotnet new $project_type --name "$project_name"
}

create_main_project_with_auth() {
    dotnet new $project_type --name $project_name --auth Individual --use-local-db
}

create_test_project() {
    dotnet new xunit --name $project_name.UnitTests
}

add_moq_package() {
    dotnet add package Moq
}

if [[ -z "$project_name" || -z "$project_type" || -z "$use_auth" ]]
then
    func_result="$(print_usage)"
    echo $func_result
    exit    
fi

create_project_directory

cd $project_name

create_directories
create_sln
start_git
create_gitignore
create_readme

cd src

if [ "$use_auth" == true ]
then
    create_main_project_with_auth
else 
    create_main_project
fi

cd ../tests

create_test_project
cd $project_name.UnitTests
add_moq_package

cd ../../

attach_projects_to_sln

