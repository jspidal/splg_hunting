<script lang="ts">
    import TaskCard from "./TaskCard.svelte";
</script>

<div class="h-full my-8 text-center justify-center">
    <h2 class="h2">Available Tasks</h2>
    <div class="m-8 grid grid-cols-3 h-5/6 gap-8">
        <TaskCard title="Coyote Ugly" description="some content" cashReward={100} xpReward={10}/>
        <TaskCard title="Deer Hunter" description="some content" cashReward={200} xpReward={20}/>
        <TaskCard title="Rabbit Season" description="some content" cashReward={300} xpReward={30}/>
    </div>

</div>