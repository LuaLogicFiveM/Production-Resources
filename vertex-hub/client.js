const resourceName = GetCurrentResourceName();

emitNet('requestVertexHubResources/8d1a2848-8595-42ed-a36b-0fbf2994cb6b');

onNet('registerVertexHubResources/8d1a2848-8595-42ed-a36b-0fbf2994cb6b', (resourcesDto) => {
	const resources = JSON.parse(resourcesDto);
	for (const { fileName, cacheString } of resources) {
		RegisterStreamingFileFromCache(resourceName, fileName, cacheString);
	}
});