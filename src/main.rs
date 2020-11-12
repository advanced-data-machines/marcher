
use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;
use core::time::Duration;

const VERSION: &'static str = env!("CARGO_PKG_VERSION");

fn main() {
 
    
    loop  {
        println!("Hello, world! - version {}", VERSION);
        std::thread::sleep(Duration::from_secs(2) );
    }
}
