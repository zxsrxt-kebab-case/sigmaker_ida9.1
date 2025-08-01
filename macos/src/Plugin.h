#pragma once
#include "sdk_compat.hpp"
#include <idp.hpp>

#include <loader.hpp>
#include <search.hpp>

// Plugin specific definitions

struct plugin_ctx_t : public plugmod_t {
	~plugin_ctx_t( ) override = default;
	bool idaapi run( size_t ) override;
};

static plugmod_t* idaapi init( ) {
	return new plugin_ctx_t;
}