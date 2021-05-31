#include <stdio.h>
#define SIZE 5
void swap(int x, int y);
void insertion(int array[SIZE],int nums);
void sortedArray(int arr[SIZE],int num);
int main(){

    int arr[5] = {3,5,4,2,1};
   insertion(arr,5);
   
}
void insertion(int *array,int nums){
     for(int i=1; i < nums; i++){
        int start = array[i];
        for(int j=i-1;j <nums;j++){
            if(start > array[j+1]){
               int temp = start;
                start = array[j+1];
                array[j+1] = temp;
            }else{
                j = i-1;
            }
        }
    }
    sortedArray(array,5);
}
void swap(int x,int y){
   
}

void sortedArray(int *arr,int num){
    for (int i = 0; i < num; i++){
        printf("%d \t",arr[i]);
    }
    
}