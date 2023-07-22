import numpy as np
from numpy.testing import assert_array_equal

import pytest

from slycot import ab13bd

def test_no_change_args():
    # ab13md must not change its arguments
    # regression; see gh-199
    a = np.array([[0.0, 1.0],[-0.5, -0.1]])
    b = np.array([[0.],[1.]])
    c = np.eye(2)
    d = np.zeros((2,1))

    acopy = a.copy()
    bcopy = b.copy()
    ccopy = c.copy()
    dcopy = d.copy()

    dico = 'C'
    jobn = 'H'

    n, m = b.shape
    p = c.shape[0]

    ab13bd(dico, jobn, n, m, p, a, b, c, d)
    assert_array_equal(a, acopy)
    assert_array_equal(b, bcopy)
    assert_array_equal(c, ccopy)
    assert_array_equal(d, dcopy)
