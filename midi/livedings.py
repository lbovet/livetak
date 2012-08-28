from mididings import *

run(
    scenes = {
        1:  Scene("channel 1 only",
                Channel(1)
            ),
        2:  Scene("channel 2, program 23",
                Channel(2),
                Program(23) >> Channel(2)
            ),
        3:  Scene("channel 2, program 42",
                Channel(2),
                Program(42) >> Channel(2)
            ),
        4:  Scene("channel 1/3 split",
                KeySplit('c3',
                    Channel(1),
                    Channel(3)
                )
            ),
    },
    control = Filter(PROGRAM) >> SceneSwitch(),
    pre = ~Filter(PROGRAM),
)
