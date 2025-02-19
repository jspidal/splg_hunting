import { DebugAction } from '@typings/events'
import { toggleVisible } from './visibility'
import debugLocale from './debugLocale.json'
import { DebugEventSend } from '@utils/eventsHandlers'
import { Receive } from '@enums/events'
import { DataEvent } from '@typings/misc'

/**
 * The initial debug actions to run on startup
 */
const InitDebug: DebugAction[] = [
    {
        label: 'Visible',
        action: () => toggleVisible(true),
        delay: 500,
    },
    {
        label: 'Initial Data',
        action: () => {
            DebugEventSend<DataEvent>(Receive.data, { locale: JSON.stringify(debugLocale) })
        },
    }
]

export default InitDebug


export function InitialiseDebugSenders(): void {
    for (const debug of InitDebug) {
        setTimeout(() => {
            debug.action()
        }, debug.delay || 0)
    }
}
