message(STATUS "Start: Generate XCFramework")
message(STATUS "Checking if existing framework exists")

set(staticLibrary ${LIB_BINARY_DIR}/${LIB_PROJECT_NAME}.a)
set(headerFolder ${LIB_PROJECT_DIR}/include)
set(outputFramework ${LIB_PROJECT_DIR}/../Frameworks/${LIB_PROJECT_NAME}.xcframework)

# remove framework if it exists
if(EXISTS ${outputFramework})

    message(STATUS "Found existing framework, removing")
    file(REMOVE_RECURSE ${outputFramework})

endif()

# run from bash/terminal
message(STATUS "Generating XCFramework from static library")
execute_process(
        COMMAND bash -c "xcodebuild \
                            -create-xcframework \
                            -library ${staticLibrary}\
                            -headers ${headerFolder}/ \
                            -output ${outputFramework}"
)

message(STATUS "Generating module.modulemap for XCFramework")

# for all targets within the XCFramework, generate a module.modulemap file

# find all targets, every folder within the .xcframework folder will be a target
set(frameworkTargets "")
file(GLOB targets RELATIVE ${outputFramework} ${outputFramework}/*)

foreach(target ${targets})

    #check if it matches our folderName
    set(currentFolder ${outputFramework}/${target})

    if(IS_DIRECTORY ${currentFolder})
        message(STATUS "Found target: ${target}, writing module.modulemap")

        # we know the structure from this point onwards, thus we write into the header file
        configure_file(${LIB_PROJECT_DIR}/inputs/module.modulemap.in ${currentFolder}/Headers/module.modulemap)
    endif ()

endforeach ()