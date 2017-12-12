if( NOT TARGET Cinder-NanoVG )
	get_filename_component( Cinder-NanoVG_PATH "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE )

	list( APPEND Cinder-NanoVG_SOURCES
		${Cinder-NanoVG_PATH}/src/ci_nanovg.cpp
		${Cinder-NanoVG_PATH}/src/ci_nanovg_gl.cpp
		${Cinder-NanoVG_PATH}/src/SvgRenderer.cpp
	)
	add_library( Cinder-NanoVG ${Cinder-NanoVG_SOURCES} )

	if( NOT TARGET cinder )
	    include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
	    find_package( cinder REQUIRED PATHS
	        "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
	        "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()

	target_include_directories( Cinder-NanoVG PUBLIC "${Cinder-NanoVG_PATH}/include" )

	get_filename_component( NanoVG_Deps_PATH "${Cinder-NanoVG_PATH}/deps/nanovg/src" ABSOLUTE )
	add_library( NanoVGDeps ${NanoVG_Deps_PATH}/nanovg.c )
	target_include_directories( NanoVGDeps PUBLIC "${NanoVG_Deps_PATH}" )
	add_dependencies( Cinder-NanoVG NanoVGDeps )

	target_link_libraries( Cinder-NanoVG PUBLIC NanoVGDeps PRIVATE cinder)

endif()
