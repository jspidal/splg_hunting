<script lang="ts">
    export let title: string;
    export let description: string;
    export let cashReward: number;
    export let xpReward: number;
</script>

<div class="flex flex-col card variant-soft-surface overflow-hidden">
    <header class="card-header flex flex-row place-content-center">
        <h2 class="h2">{title}</h2>
        <span class="ml-auto">
            <h3 class="h3 text-success-600">${cashReward}</h3>
            <h4 class="h4 text-success-600">{xpReward}XP</h4>
        </span>
    </header>
    <section class="flex flex-col flex-initial">
        <h3 class="h3"> Requirements: </h3>
        <ul class="list">
            <li>
                <span class="flex-auto">Testing</span>
            </li>
            <li>
                <span class="flex-auto">Testing 2</span>
            </li>
        </ul>
        {description}
    </section>
</div>