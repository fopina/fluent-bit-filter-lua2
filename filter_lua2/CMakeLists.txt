set(src
  lua_config.c
  lua.c)

if(MSVC)
  FLB_PLUGIN(filter_lua2 "${src}" "")
else()
  FLB_PLUGIN(filter_lua2 "${src}" "m")
endif()

add_definitions(-DFLB_FILTER_LUA_USE_MPACK)
