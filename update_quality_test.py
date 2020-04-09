import pytest

from award import Award
from update_quality import update_quality


@pytest.mark.parametrize("initial_expires_in,initial_quality,expected_quality",
        [
            (5,10,9),
            (0,10,8),
            (-10,10,8),
            (5,0,0),
            ])
def test_normal_award(initial_expires_in, initial_quality, expected_quality):
    award = Award(name = 'NORMAL ITEM', expires_in = initial_expires_in, quality
            = initial_quality)
    update_quality([award])
    assert award.expires_in == initial_expires_in - 1
    assert award.quality == expected_quality


@pytest.mark.parametrize("initial_expires_in,initial_quality,expected_quality",
        [
            (5,10,11),
            (5,50,50),
            (0,10,12),
            (0,49,50),
            (0,50,50),
            (-10,10,12),
            (-10,50,50),
            ])
def test_blue_first(initial_expires_in, initial_quality, expected_quality):
    award = Award(name = 'Blue First', expires_in = initial_expires_in, quality
            = initial_quality)
    update_quality([award])
    assert award.expires_in == initial_expires_in - 1
    assert award.quality == expected_quality


@pytest.mark.parametrize("initial_expires_in,initial_quality,expected_quality",
        [
            (5,80,80),
            (0,80,80),
            (-10,80,80),
            ])
def test_blue_distinction(initial_expires_in, initial_quality,
        expected_quality):
    award = Award(name = 'Blue Distinction Plus', expires_in =
            initial_expires_in, quality = initial_quality)
    update_quality([award])
    assert award.expires_in == initial_expires_in
    assert award.quality == expected_quality


@pytest.mark.parametrize("initial_expires_in,initial_quality,expected_quality",
        [
            (11,10,11),
            (10,10,12),
            (10,50,50),
            (6,10,12),
            (6,50,50),
            (5,10,13),
            (5,50,50),
            (1,10,13),
            (1,50,50),
            (0,10,0),
            (-10,10,0),
            ])
def test_blue_compare(initial_expires_in, initial_quality, expected_quality):
    award = Award(name = 'Blue Compare', expires_in = initial_expires_in,
            quality = initial_quality)
    update_quality([award])
    assert award.expires_in == initial_expires_in - 1
    assert award.quality == expected_quality


@pytest.mark.parametrize("initial_expires_in,initial_quality,expected_quality",
        [
            (5,10,8),
            (5,0,0),
            (0,10,6),
            (0,0,0),
            (-10,10,6),
            (-10,0,0),
            ])
#@pytest.mark.xfail(reason = 'Pending')
def test_blue_star(initial_expires_in, initial_quality, expected_quality):
    award = Award(name = 'Blue Star', expires_in = initial_expires_in,
            quality = initial_quality)
    update_quality([award])
    assert award.expires_in == initial_expires_in - 1
    assert award.quality == expected_quality


def test_several_awards():
    award1 = Award(name = 'NORMAL ITEM', expires_in = 5, quality = 10)
    award2 = Award(name = 'Blue First', expires_in = 3, quality = 10)
    update_quality([award1, award2])

    assert award1.quality == 9
    assert award1.expires_in == 4
    assert award2.quality == 11
    assert award2.expires_in == 2
