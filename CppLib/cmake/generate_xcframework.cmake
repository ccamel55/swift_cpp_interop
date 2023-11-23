message(STATUS "Start: Generate XCFramework")
message(STATUS "Checking if existing framework exists")

set(staticLibrary ${LIB_BINARY_DIR}/${LIB_PROJECT_NAME}.a)
set(outputFramework ${LIB_PROJECT_DIR}/../Frameworks/${LIB_PROJECT_NAME}.xcframework)
set(headerOutput ${LIB_BINARY_DIR}/minimal_headers)

# remove framework if it exists
if(EXISTS ${outputFramework})

    message(STATUS "Found existing framework, removing")
    file(REMOVE_RECURSE ${outputFramework})

endif()

# remove minmal headers if it exists
if(EXISTS ${headerOutput})

    message(STATUS "Found existing minimal header, removing")
    file(REMOVE_RECURSE ${headerOutput})

endif()

# move all includes that are used into the exported header folder
file(STRINGS "${LIB_INCLUDE_FILE_TXT_FILE}" lines)
list(FILTER lines INCLUDE REGEX "^.*${LIB_PROJECT_DIR}.*$")

foreach (line ${lines})

    # remove .. from file
    string(REGEX REPLACE "^[. ]" ""  line ${line})

    # convert into relative path
    string(REGEX REPLACE "^${LIB_PROJECT_DIR}/" ""  line ${line})

    # remove name "include"
    string(REGEX REPLACE "^include/" ""  lineNoInclude ${line})

    # append to list of headers
    configure_file(${LIB_PROJECT_DIR}/${line} ${headerOutput}/${lineNoInclude} COPYONLY)

endforeach ()

# run from bash/terminal
message(STATUS "Generating XCFramework from static library")
execute_process(
        COMMAND bash -c "xcodebuild \
                            -create-xcframework \
                            -library ${staticLibrary}\
                            -headers ${headerOutput}/ \
                            -output ${outputFramework}"
)

message(STATUS "Generating module.modulemap for XCFramework")

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


