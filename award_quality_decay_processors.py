# need this import for type annotations
from __future__ import annotations


# only import Award if we're type checking
# otherwise we'll get a circular import error
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from award import Award


from abc import ABC, abstractmethod


class QualityDecayProcessor(ABC):
    @property
    @abstractmethod
    def VALID_AWARD_NAME(self) -> str:
        pass

    @property
    @abstractmethod
    def DECAY_AMOUNT(self) -> int:
        pass

    def __init__(self, award: Award) -> None:
        if award is None:
            return

        if award.name != self.VALID_AWARD_NAME:
            raise InvalidAwardForProcessor(award.name)

        self.award = award

    @abstractmethod
    def decay(self) -> None:
        pass


class UnknownAwardQualityDecayProcessorException(Exception):
    """raised when an award name doesn't have an associated processor"""


class InvalidAwardForProcessor(Exception):
    """raised when the wrong award is given to a processor"""


def retrieve_processor(award: Award) -> QualityDecayProcessor:
    processor_map = {
        "Blue First": BlueFirst,
        "Blue Compare": BlueCompare,
        "Blue Distinction Plus": BlueDistinctionPlus,
        "NORMAL ITEM": NormalItem,
        "Blue Star": BlueStar,
    }

    if award.name not in processor_map:
        raise UnknownAwardQualityDecayProcessorException(
            f"No quality decay processor for: {award.name}"
        )

    return (processor_map.get(award.name))(award)


class BlueFirst(QualityDecayProcessor):
    @property
    def VALID_AWARD_NAME(self) -> str:
        return "Blue First"

    @property
    def DECAY_AMOUNT(self) -> int:
        return 1

    def decay(self) -> None:
        self.award.quality += self.DECAY_AMOUNT

        if self.award.expires_in >= 0:
            return

        self.award.quality += self.DECAY_AMOUNT


class BlueCompare(QualityDecayProcessor):
    @property
    def VALID_AWARD_NAME(self) -> str:
        return "Blue Compare"

    @property
    def DECAY_AMOUNT(self) -> int:
        return 1

    def decay(self) -> None:
        self.award.quality += self.DECAY_AMOUNT

        if self.award.expires_in < 10:
            # decay again
            self.award.quality += self.DECAY_AMOUNT

        if self.award.expires_in < 5:
            # decay again again
            self.award.quality += self.DECAY_AMOUNT

        if self.award.expires_in >= 0:
            return

        # set quality to zero if the award is expired
        self.award.quality = 0


class BlueDistinctionPlus(QualityDecayProcessor):
    @property
    def VALID_AWARD_NAME(self) -> str:
        return "Blue Distinction Plus"

    @property
    def DECAY_AMOUNT(self) -> int:
        return 0

    def decay(self):
        pass


class NormalItem(QualityDecayProcessor):
    @property
    def VALID_AWARD_NAME(self) -> str:
        return "NORMAL ITEM"

    @property
    def DECAY_AMOUNT(self) -> int:
        return 1

    def decay(self):
        self.award.quality -= self.DECAY_AMOUNT
        if self.award.expires_in >= 0:
            return

        self.award.quality -= self.DECAY_AMOUNT


class BlueStar(QualityDecayProcessor):
    @property
    def VALID_AWARD_NAME(self) -> str:
        return "Blue Star"

    @property
    def DECAY_AMOUNT(self) -> int:
        return 2

    def decay(self):
        self.award.quality -= self.DECAY_AMOUNT

        if self.award.expires_in >= 0:
            return

        self.award.quality -= self.DECAY_AMOUNT
