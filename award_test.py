import pytest

from award import Award


def test_award_quality_can_never_be_negative():
    award = Award("some name", 10, -200)
    assert award.quality == 0

    award.quality = 5
    assert award.quality == 5

    award.quality = -2000
    assert award.quality == 0


def test_award_quality_can_never_be_set_greater_than_50():
    award = Award("some name", 10, 200)
    assert award.quality == 50

    award.quality = 5
    assert award.quality == 5

    award.quality = 8000
    assert award.quality == 50


def test_award_quality_for_blue_distinction_plus_is_always_eighty():
    award = Award("Blue Distinction Plus", 10, 200)
    assert award.quality == 80

    award.quality = 5
    assert award.quality == 80

    award.quality = 500
    assert award.quality == 80

    award.quality = -5
    assert award.quality == 80


def test_award_decrement_expires_in_does_not_change_blue_distinction_plus():
    award = Award("Blue Distinction Plus", 10, 200)
    assert award.expires_in == 10

    award.decrement_expires_in()
    assert award.expires_in == 10


def test_award_expires_in_setter_does_change_blue_distinction_plus():
    award = Award("Blue Distinction Plus", 10, 200)
    assert award.expires_in == 10

    award.expires_in = 50
    assert award.expires_in == 50
