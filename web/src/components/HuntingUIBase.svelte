<script lang="ts">
	import { AppBar } from '@skeletonlabs/skeleton';
	import HuntingIcon from '@components/HuntingIcon.svelte';
	import { LOCALE } from '@stores/ui';
	import IcBaselineHome from '~icons/ic/baseline-home';
	import IcBaselinePerson from '~icons/ic/baseline-person';
	import { path } from 'elegua';

	$: classesActive = (href: string) => {
		return $path === href ? 'variant-soft-primary' : '';
	};
</script>

<div class="flex h-screen flex-auto items-center justify-center">
	<div
		class="bg-surface-50-900-token rounded-container-token mx-auto flex h-[80vh] w-full max-w-[90vw] flex-col md:max-w-[85vw] lg:max-w-[80vw] xl:max-w-[75vw] 2xl:max-w-[70vw]"
	>
		<AppBar
			class="rounded-tl-container-token rounded-tr-container-token p-2 md:p-3 xl:p-4"
			gridColumns="grid-cols-3"
			slotDefault="place-self-center"
			slotTrail="place-self-end self-center"
		>
			<svelte:fragment slot="lead">
				<HuntingIcon
					class="fill-token h-[3.5rem] w-[3.5rem] xl:h-[4rem] xl:w-[4rem] 2xl:h-[4.5rem] 2xl:w-[4.5rem]"
				/>
			</svelte:fragment>

			<h1 class="h1 text-[clamp(1.5rem,2vw,3rem)]">
				{$LOCALE.HUNTING_LABEL}
			</h1>

			<svelte:fragment slot="trail">
				<div class="inline-flex gap-4">
					<a
						href="/"
						class="rounded-container-token flex flex-row items-center gap-1 p-2 {classesActive(
							'/',
						)}"
					>
						<IcBaselineHome class="h-[1em] w-[1em]" />
						<span>{$LOCALE.HOME_LABEL}</span>
					</a>
					<a
						href="/profile"
						class="rounded-container-token flex flex-row items-center gap-1 p-2 {classesActive(
							'/profile',
						)}"
					>
						<IcBaselinePerson class="h-[1em] w-[1em]" />
						<span>{$LOCALE.PROFILE_LABEL}</span>
					</a>
				</div>
			</svelte:fragment>
		</AppBar>
		<div class="flex-1 overflow-auto p-4">
			<slot />
		</div>
	</div>
</div>
