# need this import for type annotations
from __future__ import annotations

from abc import ABC, abstractmethod

# only import Award if we're type checking
# otherwise we'll get a circular import error
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from award import Award


class QualityDecayProcessor(ABC):
    @property
    @abstractmethod
    def valid_award_name(self) -> str:
        pass

    @property
    @abstractmethod
    def decay_amount(self) -> int:
        pass

    def __init__(self, award: Award) -> None:
        if award is None:
            return

        if award.name != self.valid_award_name:
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
    def valid_award_name(self) -> str:
        return "Blue First"

    @property
    def decay_amount(self) -> int:
        return 1

    def decay(self) -> None:
        self.award.quality += self.decay_amount

        if self.award.expires_in >= 0:
            return

        self.award.quality += self.decay_amount


class BlueCompare(QualityDecayProcessor):
    @property
    def valid_award_name(self) -> str:
        return "Blue Compare"

    @property
    def decay_amount(self) -> int:
        return 1

    def decay(self) -> None:
        self.award.quality += self.decay_amount

        if self.award.expires_in < 10:
            # decay again
            self.award.quality += self.decay_amount

        if self.award.expires_in < 5:
            # decay again again
            self.award.quality += self.decay_amount

        if self.award.expires_in >= 0:
            return

        # set quality to zero if the award is expired
        self.award.quality = 0


class BlueDistinctionPlus(QualityDecayProcessor):
    @property
    def valid_award_name(self) -> str:
        return "Blue Distinction Plus"

    @property
    def decay_amount(self) -> int:
        return 0

    def decay(self):
        pass


class NormalItem(QualityDecayProcessor):
    @property
    def valid_award_name(self) -> str:
        return "NORMAL ITEM"

    @property
    def decay_amount(self) -> int:
        return 1

    def decay(self):
        self.award.quality -= self.decay_amount
        if self.award.expires_in >= 0:
            return

        self.award.quality -= self.decay_amount


class BlueStar(QualityDecayProcessor):
    @property
    def valid_award_name(self) -> str:
        return "Blue Star"

    @property
    def decay_amount(self) -> int:
        return 2

    def decay(self):
        self.award.quality -= self.decay_amount

        if self.award.expires_in >= 0:
            return

        self.award.quality -= self.decay_amount
