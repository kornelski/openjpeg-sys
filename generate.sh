#!/bin/bash

bindgen --opaque-type=FILE \
        --blocklist-type='^_.*' \
        --allowlist-function='^opj.*' \
        --allowlist-type='^opj.*' \
        --allowlist-var='^OPJ.*' \
        --size_t-is-usize \
        --rust-target=1.26 \
        --rustified-enum='.*' \
        --distrust-clang-mangling --no-layout-tests \
        vendor/src/lib/openjp2/openjpeg.h -- -Ivendor/src/src/lib/openjp2/ -Iconfig/ |
        sed -E "s/pub type FILE.*/use libc::FILE;/;
                s/ @param +([^ ]+)/ * '\1' — /;
                s/#\\[doc = \"([^\"]*)\"\\]/\\/\\/\\/\1/;
                s/pub type OPJ_BYTE.*/pub type OPJ_BYTE = u8;/;
                2s/^/use std::os::raw::*;/;
                s/::std::os::raw:://g" > src/ffi.rs
