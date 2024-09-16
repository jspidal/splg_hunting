<script lang="ts">
    import { Send } from "@enums/events";
    import { TASK_BUTTONS_VISIBLE } from "@stores/stores"
    import { SendEvent } from "@utils/eventsHandlers";
    export let taskId: number;
    export let title: string;
    export let cashReward: number;
    export let xpReward: number;
    export let canClaim: boolean;

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
        <h3 class="h3"> Requirements: </h3>
        <ul class="list">
            <li>
                <span>Testing</span>
            </li>
            <li>
                <span>Testing 2</span>
            </li>
        </ul>
    </section>
    {#if $TASK_BUTTONS_VISIBLE}
    <footer class="card-footer ml-auto">
        <button class="btn btn-lg variant-soft-primary" disabled={!canClaim} on:click={handleTaskButtonClick}>Complete</button>
    </footer>
    {/if}
</div>