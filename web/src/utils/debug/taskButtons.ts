import { Receive } from '@enums/events'
import { DebugEventSend } from '@utils/eventsHandlers'
/**
 * The debug response for the visibility debug action.
 */
export function toggleButtonsVisible(visibility: boolean): void {
    DebugEventSend(Receive.taskButtons, visibility)
}