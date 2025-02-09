<script lang="ts">
    import { SendEvent } from "@utils/eventsHandlers";
    import TaskCard from "./TaskCard.svelte";
    import { onMount } from "svelte";
    import { Send } from "@enums/events";
    import type { Task } from "@typings/misc";

    let tasks: Task[] = [];

    onMount(() => {
        SendEvent<any, Task[]>(Send.requestTasks).then((data) => {
            tasks = data;
        });
    });

</script>

<div class="h-full overflow-hidden flex flex-col items-center justify-center">
        {#await tasks}
            <div class="flex flex-row">
                <h1 class="h1">Loading...</h1> 
            </div>
        {:then tasks}
            <h2 class="h2">Available Tasks</h2>
            <div class="m-8 mt-12 flex flex-row flex-wrap gap-8 justify-center">
                {#each tasks as task}
                    <TaskCard taskId={task.id} title={task.title} cashReward={task.cashReward} xpReward={task.xpReward} canClaim={task.canClaim} requirements={task.requirements}/>
                {/each}
            </div>
        {/await}
        <!-- <TaskCard title="Coyote Ugly" cashReward={100} xpReward={10} canClaim={true}/>
        <TaskCard title="Deer Hunter" cashReward={200} xpReward={20} canClaim={true}/>
        <TaskCard title="Rabbit Season" cashReward={300} xpReward={30} canClaim={false}/>
        <TaskCard title="Bear Necessities" cashReward={400} xpReward={40} canClaim={true}/>
        <TaskCard title="Duck Hunt" cashReward={500} xpReward={50} canClaim={false}/>
        <TaskCard title="Elk Hunt" cashReward={600} xpReward={60} canClaim={false}/> -->
</div>