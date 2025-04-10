import { Send } from "@enums/events"
import { DebugEventCallback } from "@typings/events"
import { Task } from "@typings/tasks"
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
            const tasks: Task[] = [
                {
                    id: 1,
                    title: 'Boar-d Yet?',
                    cashReward: 250,
                    xpReward: 5,
                    requirements: {
                        'carcass_boar': { amount: 1 }, // Example of a requirement with an item type and amount
                    },
                    completionRatio: 0.5
                },
                {
                    id: 2,
                    title: 'Hawk Hunting',
                    cashReward: 15,
                    xpReward: 12,
                    requirements: {
                        'carcass_hawk': { amount: 1 },
                    },
                    completionRatio: 0.8
                },
                {
                    id: 3,
                    title: 'Rabbit Hunting',
                    cashReward: 115,
                    xpReward: 5,
                    requirements: {
                        'carcass_cormorant': { amount: 1}
                    },
                    completionRatio: 0.2
                },
                {
                    id: 4,
                    title: 'Murder Cat Hunting',
                    cashReward: 100,
                    xpReward: 10, 
                    requirements: {
                        'carcass_mtlion': {amount: 1 }
                    },
                    completionRatio: 0.7
                },
                {
                    id: 5,
                    title: 'Rabbit Season',
                    cashReward: 100,
                    xpReward: 10,
                    requirements: {
                        'carcass_rabbit': {amount : 3}
                    },
                    completionRatio: 1.1
                },
                {
                    id: 6,
                    cashReward: 100,
                    xpReward: 10,
                    requirements: {
                        'carcass_deer': {amount: 2}
                    },
                    completionRatio: 0.9
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
