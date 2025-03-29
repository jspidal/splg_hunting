export interface Config {
    fallbackResourceName: string;
    allowEscapeKey: boolean;
}

export interface Task {
    id: number;
    title?: string;
    cashReward: number;
    xpReward: number;
    requirements: string[];
    completionRatio: number;
}

export interface DataEvent {
    locale: string;
}