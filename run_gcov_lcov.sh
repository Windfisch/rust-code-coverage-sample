#!/bin/sh

HILIGHT='\e[34m\e[1m'
NORMAL='\e[0m'

# check for available software
if ! which genhtml &> /dev/null; then
	echo -e "Error: Could not locate the ${HILIGHT}genhtml${NORMAL} binary, which is part"
	echo -e "       of the ${HILIGHT}lcov${NORMAL} package. Please install it first."
	exit 1
fi

rm -rf ./target

export CARGO_INCREMENTAL=0
export RUSTDOCFLAGS="-Cpanic=abort"
export RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort"

cargo build

cargo run

grcov . -s . -t lcov --llvm --branch --ignore-not-existing -o ./target/debug/coverage.lcov

genhtml --rc lcov_branch_coverage=1 -o target/debug/lcov_report --show-details --highlight --ignore-errors source --legend target/debug/coverage.lcov

echo
echo -e "Open your report by viewing ${HILIGHT}target/debug/lcov_report/index.html${NORMAL} in a web browser"
