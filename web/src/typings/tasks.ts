export interface Task {
    id: number;
    title?: string;
    cashReward: number;
    xpReward: number;
    requirements: TaskRequirements;
    completionRatio: number;
}

// Copy of the TaskRequirement type from the game code (config/shared.lua).
export interface TaskRequirement {
    amount: number;
    weapon?: string;
    quality?: string;
    headshot?: boolean;
    minDistance?: number;
    maxDistance?: number;
}

export interface TaskRequirements { 
    [key: string]: TaskRequirement 
};
