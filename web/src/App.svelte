<script lang="ts">
	import { CONFIG, IS_BROWSER } from '@stores/stores';
	import { InitialiseListen } from '@utils/listeners';
	import Visibility from '@providers/Visibility.svelte';
	import HuntingUIBase from '@components/HuntingUIBase.svelte';
	import { path } from 'elegua';
	import HuntingHome from '@components/HuntingHome.svelte';

	CONFIG.set({
		fallbackResourceName: 'splg_hunting',
		allowEscapeKey: true,
	});

	InitialiseListen();
</script>

<Visibility>
	<!-- <ImageHolder /> -->
	<HuntingUIBase>
		{#if $path === '/'}
			<HuntingHome />
		{:else if $path === '/profile'}
			<p>Profile</p>
		{:else}
			<p>Something went wrong</p>
		{/if}
	</HuntingUIBase>
</Visibility>

{#if import.meta.env.DEV}
	{#if $IS_BROWSER}
		{#await import('./providers/Debug.svelte') then { default: Debug }}
			<Debug />
		{/await}
	{/if}
{/if}
