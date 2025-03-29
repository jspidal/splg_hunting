<script lang="ts">
	import { ProgressBar } from '@skeletonlabs/skeleton';
	import { Send } from '@enums/events';
	import { TASK_BUTTONS_VISIBLE } from '@stores/ui';
	import { SendEvent } from '@utils/eventsHandlers';
	import { LOCALE } from '@stores/ui';
	export let taskId: number;
	export let title: string = null;
	export let cashReward: number;
	export let xpReward: number;
	export let requirements: string[] = [];
	export let completionRatio: number = undefined;

	function handleTaskButtonClick() {
		SendEvent(Send.claimTask, taskId);
	}
</script>

<div
	class="card variant-soft-surface flex min-w-[25%] flex-grow flex-col justify-between"
>
	<header class="card-header flex flex-row place-content-center">
		<h3 class="h3">
			{title ? title : 'Hunting Task'}
		</h3>
		<span class="ml-auto inline-grid gap-2">
			<span class="chip rounded-token variant-soft-success cursor-auto">
				<p class="text-base font-bold">
					${cashReward}
				</p>
			</span>
			<span class="chip rounded-token variant-soft-secondary cursor-auto">
				<p class="text-base font-bold">
					{xpReward}XP
				</p>
			</span>
		</span>
	</header>
	<section class="place-self-start pl-4 xl:py-4">
		{#if requirements.length > 0}
			<h4 class="h4">{$LOCALE.REQUIREMENTS_LABEL}</h4>
			<ul class="list">
				{#each requirements as requirement}
					<li>
						<span>&#x2022</span>
						<span class="flex-auto">{requirement}</span>
					</li>
				{/each}
			</ul>
		{/if}
	</section>
	<footer class="card-footer flex items-center gap-4 overflow-hidden">
		<ProgressBar
			height="h-2"
			rounded="rounded-token"
			track="bg-surface-400-500-token"
			meter="bg-primary-500"
			value={completionRatio}
			max={1}
		/>
		{#if $TASK_BUTTONS_VISIBLE}
			<button
				class="btn variant-soft-primary ml-auto"
				disabled={completionRatio < 1}
				on:click={handleTaskButtonClick}
			>
				{$LOCALE.BUTTON_COMPLETE_LABEL}
			</button>
		{/if}
	</footer>
</div>
