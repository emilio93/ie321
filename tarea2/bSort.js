// procedure bubbleSort( A : list of sortable items, len )
//     n = length(A)
//     repeat
//         newn = 0
//         for i = 1 to n-1 inclusive do
//             if A[i-1] > A[i] then
//                 swap(A[i-1], A[i])
//                 newn = i
//             end if
//         end for
//         n = newn
//     until n = 0
// end procedure


function BubbleSort(array) {
  this.arr = array;
  this.sigN = 0;
  this.i = 0;

  // swaps this.arr[i] with this.arr[j]
  swap = () => {
    let ival = this.arr[this.i];
    let jval = this.arr[this.i+1];
    this.arr[this.i] = jval;
    this.arr[this.i+1] = ival;

    this.sigN = this.i + 1;
  };

  this.sort = () => {
    // buuble_sort
    let n = this.arr.length;
    // bSort_while
    do {
        this.sigN = 0;
        // bSort_sort
        for (this.i = 0; this.i < (this.arr.length - 1); this.i++)
            if (this.arr[this.i] > this.arr[this.i+1]) {
                // bSort_swap
                let ival = this.arr[this.i];
                let jval = this.arr[this.i+1];
                this.arr[this.i] = jval;
                this.arr[this.i+1] = ival;
                this.sigN = this.i + 1;
            }
            // bSort_noswap
        n = this.sigN;
    } while (n > 0);
    return this.arr;
  };

}

let a = [87, 216, -54, 751, 1, 36, 1225, -446, -6695, -8741, 101, 9635, -9896, 4, 2008, -99, -6, 1, 544, 6, 0, 7899, 74, -42, -9];
let b = new BubbleSort(a);
console.log(b.arr);
console.log(b.sort());
