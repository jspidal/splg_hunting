import { writable, type Writable } from 'svelte/store';

/**
 * Whether the debug menu is visible or not.
 */
export const TASK_BUTTONS_VISIBLE = writable<boolean>(true);

/**
 * The current locale.
 */
export const LOCALE: Writable<{[key: string]: string}> = writable<{
    [key: string]: string;
}>({});