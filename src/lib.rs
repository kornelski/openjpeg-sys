#[allow(bad_style)]
mod ffi;

pub use crate::ffi::*;

#[test]
fn poke() {
    unsafe {
        let tmp = opj_create_compress(CODEC_FORMAT::OPJ_CODEC_J2K);
        assert!(!tmp.is_null());
        opj_destroy_codec(tmp);
    }
}
