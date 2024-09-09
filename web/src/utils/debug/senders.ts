import { DebugItem } from '@typings/events'
import { toggleVisible } from './visibility'
import { toggleButtonsVisible } from './taskButtons'
import { Send } from '@enums/events'
import { DebugEventSend, SendEvent } from '@utils/eventsHandlers'

/**
 * The debug actions that will show up in the debug menu.
 */
const SendDebuggers: DebugItem[] = [
    {
        label: 'Visibility',
        actions: [
            {
                label: 'True',
                action: () => toggleVisible(true),
            },
            {
                label: 'False',
                action: () => toggleVisible(false),
            },
        ],
    },
    {
        label: 'Toggle Task Buttons',
        actions: [
            {
                label: 'True',
                action: () => toggleButtonsVisible(true),
            },
            {
                label: 'False',
                action: () => toggleButtonsVisible(false),
            },
        ],
    },
    {
        label: 'Debug receiver example.',
        actions: [
            {
                label: 'Emulates a POST To Client and get back a response.',
                type: 'text',
                placeholder: 'Type text to reverse.',
                action: (value: string) => SendEvent("debug", value).then((reversed: string) => console.log(reversed,'color: red', 'color: white', 'color: green')),
            },
        ],
    },
]

export default SendDebuggers
