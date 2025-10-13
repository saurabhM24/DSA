Perfect — you’re referring to the **sliding window pattern using a single `while` loop** where both expansion and shrinking happen inside the same loop (like many LeetCode editorial templates).

Here’s a **comprehensive collection of templated formats** for all major sliding window patterns — all written in your preferred **“Step 1 expand, Step 2 shrink”** structure.

---

## 🧩 1. Fixed Size Window

### ✅ Problem Type

Given a window size `k`, compute something (sum, max, count, etc.) for every subarray/substring of length `k`.

### 🧱 Template

```java
int left = 0, right = 0;
int windowSum = 0, maxSum = 0;

while (right < n) {
    // Step 1: expand the window
    windowSum += arr[right];

    // Step 2: shrink when window size exceeds k
    if (right - left + 1 > k) {
        windowSum -= arr[left];
        left++;
    }

    // Step 3: update answer when window size == k
    if (right - left + 1 == k) {
        maxSum = Math.max(maxSum, windowSum);
    }

    right++;
}
```

### 🧩 Example

LeetCode 643 — *Maximum Average Subarray I*

---

## 🧩 2. Variable Size Window (Expand–Shrink)

### ✅ Problem Type

Find **smallest or largest** window satisfying a constraint (sum ≥ target, at most K distinct chars, etc.)

### 🧱 Template

```java
int left = 0, right = 0;
int ans = 0; // or Integer.MAX_VALUE for min window
int currentSum = 0;

while (right < n) {
    // Step 1: expand window
    currentSum += arr[right];

    // Step 2: shrink while condition violated
    while (currentSum > target) {   // condition depends on problem
        currentSum -= arr[left];
        left++;
    }

    // Step 3: update result (if valid)
    ans = Math.max(ans, right - left + 1);

    right++;
}
```

### 🧩 Example

LeetCode 209 — *Minimum Size Subarray Sum*
LeetCode 3 — *Longest Substring Without Repeating Characters*

---

## 🧩 3. Variable Window + Frequency Map (for Strings / Character Windows)

### ✅ Problem Type

Maintain a frequency map for substrings — e.g. “minimum window substring”, “anagram detection”.

### 🧱 Template

```java
Map<Character, Integer> need = new HashMap<>();
Map<Character, Integer> window = new HashMap<>();
int have = 0, needCount = need.size();
int left = 0, right = 0;
int minLen = Integer.MAX_VALUE;
int start = 0;

while (right < s.length()) {
    // Step 1: expand window
    char c = s.charAt(right);
    window.put(c, window.getOrDefault(c, 0) + 1);

    if (need.containsKey(c) && window.get(c).intValue() == need.get(c).intValue()) {
        have++;
    }

    // Step 2: shrink while window satisfies condition
    while (have == needCount) {
        // update answer
        if (right - left + 1 < minLen) {
            minLen = right - left + 1;
            start = left;
        }

        char leftChar = s.charAt(left);
        window.put(leftChar, window.get(leftChar) - 1);
        if (need.containsKey(leftChar) && window.get(leftChar) < need.get(leftChar)) {
            have--;
        }
        left++;
    }

    right++;
}
```

### 🧩 Example

LeetCode 76 — *Minimum Window Substring*
LeetCode 438 — *Find All Anagrams in a String*

---

## 🧩 4. Monotonic Deque Window

### ✅ Problem Type

Find min/max in each window (maintain decreasing or increasing deque).

### 🧱 Template

```java
Deque<Integer> dq = new ArrayDeque<>();
List<Integer> result = new ArrayList<>();

int left = 0, right = 0;

while (right < n) {
    // Step 1: expand — maintain decreasing deque (for max)
    while (!dq.isEmpty() && arr[dq.peekLast()] <= arr[right]) {
        dq.pollLast();
    }
    dq.offerLast(right);

    // Step 2: shrink if window too big
    if (dq.peekFirst() < right - k + 1) {
        dq.pollFirst();
    }

    // Step 3: collect result once first window formed
    if (right >= k - 1) {
        result.add(arr[dq.peekFirst()]);
    }

    right++;
}
```

### 🧩 Example

LeetCode 239 — *Sliding Window Maximum*

---

## 🧩 5. Two-Pointer Numeric Window (for sums/products)

### ✅ Problem Type

Array-based problems with constraints like sum < k or product < k (sorted or non-negative arrays).

### 🧱 Template

```java
int left = 0, right = 0;
long product = 1;
int count = 0;

while (right < n) {
    // Step 1: expand
    product *= arr[right];

    // Step 2: shrink until valid
    while (product >= k && left <= right) {
        product /= arr[left];
        left++;
    }

    // Step 3: use window
    count += right - left + 1;

    right++;
}
```

### 🧩 Example

LeetCode 713 — *Subarray Product Less Than K*

---

## 🧠 Summary Table

| Pattern         | Typical Problem            | Key Data Structure | Window Type   |
| --------------- | -------------------------- | ------------------ | ------------- |
| Fixed size      | Max/Avg sum                | Simple variables   | Fixed         |
| Variable size   | Longest/Shortest substring | Counters           | Expand–Shrink |
| Variable + map  | Substring match/anagram    | HashMap            | Expand–Shrink |
| Monotonic deque | Max/Min in window          | Deque              | Fixed         |
| Two pointers    | Sum/Product constraint     | Simple variables   | Expand–Shrink |
