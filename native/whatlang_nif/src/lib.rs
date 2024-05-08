use rustler::NifStruct;
use whatlang::{Info, Lang};

#[derive(NifStruct)]
#[module = "Whatlangex.Detection"]
struct Detection {
    lang: String,
    script: String,
    confidence: f64,
}

#[rustler::nif]
fn detect(sentence: &str) -> Option<Detection> {
    match whatlang::detect(sentence) {
        Some(info) => Some(decode_info(info)),
        None => None,
    }
}

#[rustler::nif]
fn code_to_name(code: &str) -> Option<&str> {
    match Lang::from_code(code) {
        Some(lang) => Some(Lang::name(lang)),
        None => None,
    }
}

#[rustler::nif]
fn code_to_eng_name(code: &str) -> Option<&str> {
    match Lang::from_code(code) {
        Some(lang) => Some(Lang::eng_name(lang)),
        None => None,
    }
}

fn decode_info(info: Info) -> Detection {
    Detection {
        lang: String::from(info.lang().code()),
        script: String::from(info.script().name()),
        confidence: info.confidence() as f64,
    }
}

rustler::init! {
    "Elixir.Whatlangex.Native",
    [detect, code_to_name, code_to_eng_name]
}
