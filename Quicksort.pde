public static class Quicksort
{
	private Quicksort() {}
	public static <T extends Comparable<T>> List<T> partition(List<T> list, int indexLow, int indexHigh) {
		T pivot = list.get(indexHigh);
		int lower = 0;
		for (int i = 0; i < list.size()-1; i++) {
			//if list[i] < pivot
			if (list.get(i).compareTo(pivot) < 0) {
				//swap elements at lower and i
				list.set(lower, list.set(i, list.get(lower)));
				lower++;
			}
		}
		//swap lower and pivot
		list.set(lower, list.set(list.size()-1, list.get(lower)));

		System.out.println(list);
		return list;
	}
}