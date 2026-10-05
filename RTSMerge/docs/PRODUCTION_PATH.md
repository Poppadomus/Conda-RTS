# RA2 production path

1. A player issues an explicit RA2 queue command.
2. The factory validates the target against its build options.
3. The production-cost gadget checks and charges the team's Spring credit ledger.
4. Queue progress advances deterministically.
5. The production-spawn gadget creates the selected UnitDef.
6. Rally coordinates are retained as synchronized unit rules state.
7. The procedural renderer chooses the unit's visual archetype from custom parameters.

The current implementation is still a compatibility layer and requires runtime Spring testing before it can be considered exact RA2/YR behavior.