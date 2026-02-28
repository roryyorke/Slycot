"""Generate scipy_openblas_symbols.def from 3 .txt files

Result is checked-in to repo; only re-run if symbols change.

The source data is from Scipy - see headers of the source .txt files
for detail.

This script is simple, and hard-coded for scipy_openblas32 wheels, 
and TBC working with version 0.3.31.22.1 (Feb 2026).
"""

from lapack_exclusions import lapack_exclusions

# scipy doesn't know about this one; from netlib:
#   DLAMC3 is intended to force  A  and  B  to be stored prior to doing
#   the addition of  A  and  B,  for use in situations where optimizers
#   might hold one of these in a register.
own_symbols = ['dlamc3']

def parse_line(line):
    """process line; return symbol as string, or None if none found"""

    # lines are "rettype identifier(args...)"
    # we want "identifier"

    pline = line.strip()
    if not pline or pline.startswith('#'):
        return None

    if pline[0] == ' ' or ' ' not in pline:
        raise ValueError(f'bad line {line}')

    _, rest = pline.split(' ', 1)

    if not rest or rest[0] == '(' or '(' not in rest:
        raise ValueError(f'bad line {line}')

    symbol, _ = rest.split('(', 1)

    return symbol


def get_symbols(filename):
    """Get all symbols from file"""
    with open(filename) as infile:
        lines = infile.readlines()

    symbols = [parse_line(line) for line in lines]

    return [s for s in symbols if s is not None]


def main():
    """Get symbols and create output file"""
    blas = get_symbols('cython_blas_signatures.txt')
    lapack = get_symbols('cython_lapack_signatures.txt')
    manual = get_symbols('manual_wrappers.txt')

    with open('scipy-openblas-symbols.def', 'wt') as outfile:
        for symbol in blas + lapack + manual + own_symbols + lapack_exclusions:
            outfile.write(f'-D{symbol.upper()}=SCIPY_{symbol.upper()}\n')


if __name__ == '__main__':
    main()
