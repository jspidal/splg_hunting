<script lang="ts">
	import { SendEvent } from '@utils/eventsHandlers';
	import TaskCard from './TaskCard.svelte';
	import { onMount } from 'svelte';
	import { Send } from '@enums/events';
	import type { Task } from '@typings/misc';
	import { LOCALE } from '@stores/ui';

	let tasks: Task[] = [];

	onMount(() => {
		SendEvent<any, Task[]>(Send.requestTasks).then(data => {
			tasks = data;
		});
	});
</script>

<div class="mx-12 flex h-full grow flex-col">
	{#if tasks.length < 1}
		<div class="flex h-full items-center justify-center">
			<h1 class="h1">{$LOCALE.LOADING_LABEL}</h1>
		</div>
	{:else}
		<!-- <h3 class="h3 mx-auto">{$LOCALE.AVAILABLE_TASKS_LABEL}</h3> -->
		<!-- <div class="flex-1"> -->
		<div class="grid h-full grid-cols-2 gap-6 p-4 py-12 xl:grid-cols-3">
			{#each tasks as task}
				<TaskCard
					taskId={task.id}
					title={task.title}
					cashReward={task.cashReward}
					xpReward={task.xpReward}
					canClaim={task.canClaim}
					requirements={task.requirements}
					completionRatio={task.completionRatio}
				/>
			{/each}
		</div>
		<!-- </div> -->
	{/if}
</div>
