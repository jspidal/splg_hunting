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
		class="bg-surface-50-900-token rounded-container-token 4xl:w-[75vw] mx-auto flex h-[80vh] w-[70vw] flex-col"
	>
		<AppBar
			class="rounded-tl-container-token rounded-tr-container-token p-[0.6rem]"
			gridColumns="grid-cols-3"
			slotDefault="place-self-center"
			slotTrail="place-self-end self-center"
		>
			<svelte:fragment slot="lead">
				<HuntingIcon class="fill-token 4xl:h-14 4xl:w-14 h-12 w-12" />
			</svelte:fragment>

			<h2 class="h2">
				{$LOCALE.HUNTING_LABEL}
			</h2>

			<svelte:fragment slot="trail">
				<div class="my-0 inline-flex flex-grow gap-4">
					<a
						href="/"
						class="rounded-container-token inline-flex items-center gap-1 p-2 {classesActive(
							'/',
						)}"
					>
						<IcBaselineHome class="h-6 w-6" />
						<span>{$LOCALE.HOME_LABEL}</span>
					</a>
					<a
						href="/profile"
						class="rounded-container-token inline-flex items-center gap-1 p-2 {classesActive(
							'/profile',
						)}"
					>
						<IcBaselinePerson class="h-6 w-6" />
						<span>{$LOCALE.PROFILE_LABEL}</span>
					</a>
				</div>
			</svelte:fragment>
		</AppBar>
		<div class="flex h-full items-center justify-center overflow-auto">
			<slot />
		</div>
	</div>
</div>
