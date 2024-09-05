<script lang="ts">
    import TaskCard from "./TaskCard.svelte";
</script>

<div class="h-full my-8 text-center justify-center">
    <h2 class="h2">Available Tasks</h2>
    <div class="m-8 mt-12 grid grid-flow-col grid-cols-3 grid-rows-2 gap-8">
        <TaskCard title="Coyote Ugly" description="some content" cashReward={100} xpReward={10} canClaim={true}/>
        <TaskCard title="Deer Hunter" description="some content" cashReward={200} xpReward={20} canClaim={true}/>
        <TaskCard title="Rabbit Season" description="some content" cashReward={300} xpReward={30} canClaim={false}/>
        <TaskCard title="Bear Necessities" description="some content" cashReward={400} xpReward={40} canClaim={true}/>
        <TaskCard title="Duck Hunt" description="some content" cashReward={500} xpReward={50} canClaim={false}/>
        <TaskCard title="Elk Hunt" description="some content" cashReward={600} xpReward={60} canClaim={false}/>
    </div>

</div>