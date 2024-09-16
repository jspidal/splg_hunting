import { Send } from "@enums/events"
import { DebugEventCallback } from "@typings/events"
import { DebugEventReceive } from "@utils/eventsHandlers"

/**
 * These Receivers will emulate what the client receives from the UI.
 * The purpose of this is to test the UI without having to run the client.
 * You are supposed to pretend to process the data you receive here and return.
 */
const ReceiveDebuggers: DebugEventCallback[] = [
    {
        action: Send.close,
        handler: () => {
            console.log('closed')
        },
    },
    {
        action: 'debug',
        handler: (data: string) => {
            const init = 'Emulates an NUICallback times. Process the data here.'

            if (typeof data !== 'string') {
                return `${init} \n The data is not a string.`
            }

            const reverse = data.split('').reverse().join('')

            const message = `${init} \n The reverse of %c${data} %cis %c${reverse}`

            return message
        },
    },
    {
        action: Send.claimTask,
        handler: () => {
            console.log('claimed task')
            return true
        },
    },
    {
        action: Send.requestTasks,
        handler: () => {
            console.log('requested tasks')
            const tasks = [
                {
                    id: 1,
                    title: 'Bear Hunting',
                    cashReward: 250,
                    xpReward: 5,
                    canClaim: true,
                },
                {
                    id: 2,
                    title: 'Deer Hunting',
                    cashReward: 15,
                    xpReward: 12,
                    canClaim: true,
                },
                {
                    id: 3,
                    title: 'Rabbit Hunting',
                    cashReward: 115,
                    xpReward: 5,
                    canClaim: true,
                },
                {
                    id: 4,
                    title: 'Murder cat Hunting',
                    cashReward: 100,
                    xpReward: 10,
                    canClaim: true,
                },
                {
                    id: 5,
                    title: 'Bird Hunting',
                    cashReward: 100,
                    xpReward: 10,
                    canClaim: true,
                },
                {
                    id: 6,
                    title: 'Task 6',
                    cashReward: 100,
                    xpReward: 10,
                    canClaim: true,
                },
                
            ];
            return tasks;
        }
    },
]

export default ReceiveDebuggers

/**
 * Initialise the debug receivers
 */
export function InitialiseDebugReceivers(): void {
    for (const debug of ReceiveDebuggers) {
        DebugEventReceive(debug.action, debug.handler)
    }
}
