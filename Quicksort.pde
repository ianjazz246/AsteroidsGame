public static class Quicksort
{
	private Quicksort() {}
	/* @return Returns the index of the pivot between the two created partitions
	 *(i.e. the upper bound of the first partition) 
	*/
	public static <T extends Comparable<T>> int partition(List<T> list, int indexLow, int indexHigh) {
		T pivot = list.get(indexLow + (indexHigh - indexLow) / 2);
		System.out.println(pivot);
		int i = indexLow - 1;
		int j = indexHigh + 1;
		while (true) {
			do {
				i++;			
			}
			//if list[i] < pivot
			//increments i until it finds an element >= pivot
			while (list.get(i).compareTo(pivot) < 0);

			do {
				j--;
			}
			//if list[j] > pivot
			//increments j until it finds an element <= pivot
			while (list.get(j).compareTo(pivot) > 0);

			if (i >= j) {
				System.out.println(list);
				return j;
			}
			//swap list[i] and list[j]
			System.out.println(list);
			System.out.println("Swap");
			list.set(i, list.set(j, list.get(i)));
			System.out.println(list);
		}
	}


}