use std::fmt::Debug;

#[derive(Debug)]
pub struct Ciao {
    pub saluto: String,
}

fn all_branches(cond: bool) {
    if cond {
        assert!(true);
    }
}

fn only_one_branch(cond: bool) {
    if cond {
        assert!(true);
    }
}

fn main() {
    let ciao = Ciao{ saluto: String::from("salve") };

    all_branches(true);
    all_branches(false);
    only_one_branch(true);

    assert!(ciao.saluto == "salve");
}
