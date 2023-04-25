import pytest

from award import Award
from award_quality_decay_processors import (
    UnknownAwardQualityDecayProcessorException,
    retrieve_processor,
    BlueFirst,
    BlueCompare,
    BlueDistinctionPlus,
    NormalItem,
    BlueStar,
)


def test_will_retrieve_the_proper_processor_for_each_award_type_name_thing():
    test_params = (
        ("Blue First", BlueFirst),
        ("Blue Compare", BlueCompare),
        ("Blue Distinction Plus", BlueDistinctionPlus),
        ("NORMAL ITEM", NormalItem),
        ("Blue Star", BlueStar),
    )

    for values in test_params:
        assert isinstance(retrieve_processor(Award(values[0], 10, 100)), values[1])


def test_will_raise_an_error_when_the_award_type_is_unknown():
    with pytest.raises(UnknownAwardQualityDecayProcessorException):
        retrieve_processor(Award("some unknown name", 10, 100))


def test_will_validate_the_decay_of_a_blue_first_award():
    award = Award("Blue First", 10, 10)
    retrieve_processor(award).decay()
    assert award.quality == 11

    award = Award("Blue First", 0, 10)
    retrieve_processor(award).decay()
    assert award.quality == 11

    award = Award("Blue First", -10, 10)
    retrieve_processor(award).decay()
    assert award.quality == 12


def test_will_validate_the_decay_of_the_blue_compare_award():
    award = Award("Blue Compare", 100, 10)
    retrieve_processor(award).decay()
    assert award.quality == 11

    # expires in 10 days or less
    award = Award("Blue Compare", 9, 10)
    retrieve_processor(award).decay()
    assert award.quality == 12

    # expires in 5 days or less
    award = Award("Blue Compare", 4, 10)
    retrieve_processor(award).decay()
    assert award.quality == 13

    # is expired
    award = Award("Blue Compare", -1, 10)
    retrieve_processor(award).decay()
    assert award.quality == 0


def test_will_validate_the_decay_of_the_blue_distinction_plus_award():
    award = Award("Blue Distinction Plus", 23, 10)
    assert award.quality == 80
    retrieve_processor(award).decay()
    assert award.quality == 80


def test_will_validate_the_decay_of_the_normal_item_award():
    award = Award("NORMAL ITEM", 10, 25)
    retrieve_processor(award).decay()
    assert award.quality == 24

    # expired
    award = Award("NORMAL ITEM", -10, 25)
    retrieve_processor(award).decay()
    assert award.quality == 23


def test_will_validate_the_decay_of_the_blue_star_award():
    # award = Award("Blue Star", 10, 25)
    # retrieve_processor(award).decay()
    # assert award.quality == 23

    # expired
    award = Award("Blue Star", -10, 25)
    retrieve_processor(award).decay()
    assert award.quality == 21
