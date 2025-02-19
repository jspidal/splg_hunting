<script lang="ts">
    import { Send } from "@enums/events";
    import { TASK_BUTTONS_VISIBLE } from "@stores/ui"
    import { SendEvent } from "@utils/eventsHandlers";
    import { LOCALE } from "@stores/ui";
    export let taskId: number;
    export let title: string;
    export let cashReward: number;
    export let xpReward: number;
    export let canClaim: boolean;
    export let requirements: string[] = [];

    function handleTaskButtonClick() {
        SendEvent(Send.claimTask, taskId);
    }

</script>

<div class="flex flex-col card variant-soft-surface w-1/4 xl:w-2/5">
    <header class="card-header flex flex-row place-content-center">
        <h2 class="h2">{title}</h2>
        <span class="ml-auto">
            <h3 class="h3 text-success-600">${cashReward}</h3>
            <h4 class="h4 text-success-600">{xpReward}XP</h4>
        </span>
    </header>
    <section class="py-4 pl-4 place-self-start">
        {#if requirements.length > 0}
        <h3 class="h3"> {$LOCALE.REQUIREMENTS_LABEL} </h3>
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
    {#if $TASK_BUTTONS_VISIBLE}
    <footer class="card-footer ml-auto">
        <button class="btn btn-lg variant-soft-primary" disabled={!canClaim} on:click={handleTaskButtonClick}>{$LOCALE.BUTTON_COMPLETE_LABEL}</button>
    </footer>
    {/if}
</div>