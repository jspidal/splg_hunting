<script lang="ts">
    import { AppBar } from '@skeletonlabs/skeleton'; 
    import HuntingIcon from '@components/HuntingIcon.svelte';
    import IcBaselineHome from '~icons/ic/baseline-home';
    import IcBaselinePerson from '~icons/ic/baseline-person'; 
    import { path } from 'elegua';

    $: classesActive = (href: string) => {
        return $path === href ? 'variant-soft-primary' : '' };
</script>

<div class="flex flex-auto justify-center items-center h-screen">
    <div class="flex flex-col w-2/3 h-3/4 bg-surface-50-900-token rounded-container-token">
        <AppBar class="rounded-tl-container-token rounded-tr-container-token p-2" gridColumns="grid-cols-3" slotDefault="place-self-center" slotTrail="place-self-end self-center">
            <svelte:fragment slot="lead">
                <!-- <img src={huntingIcon} alt="Hunting Icon" class="w-14 h-14"/> -->
                <HuntingIcon class="w-14 h-14 fill-token"/>   
            </svelte:fragment>
            
            <h1 class="h1">Hunting</h1>

            <svelte:fragment slot="trail">
                <div class="inline-flex gap-4">
                    <a href="/" class="flex flex-row gap-1 items-center rounded-container-token p-2 {classesActive('/')}"> <IcBaselineHome/> <span>Home</span></a>
                    <a href="/profile" class="flex flex-row gap-1 items-center rounded-container-token p-2 {classesActive('/profile')}"> <IcBaselinePerson/> <span>Profile</span></a>
                </div>
            </svelte:fragment>
        </AppBar>
        
        <slot />
    </div>
</div>