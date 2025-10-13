Perfect 💪 — here’s your **final comprehensive Sliding Window Patterns Notes (with while loop format)** — clean, concise, and ready to paste into your GitHub repo.

This includes:

* ✅ Fixed-size window
* ✅ Variable-size window (maximize/minimize)
* ✅ Longest substring with condition
* ✅ Distinct elements/window problems
* ✅ Count number of subarrays pattern
* ✅ Minimum window substring pattern

and all are in your preferred **while-loop format (Step 1 expand + Step 2 shrink)**.

---

# 🧩 Sliding Window Patterns — Complete Notes

Sliding window is a powerful technique to handle subarray or substring problems efficiently, especially when the array/string is contiguous.

---

## ⚙️ Common Template (While-loop Format)

```java
int left = 0, right = 0;
while (right < n) {
    // Step 1: expand the window by including arr[right]
    
    // Step 2: shrink the window until it satisfies the condition
    
    // Optionally: process the result (update max/min/count)
    
    right++;
}
```

---

## 🧩 Pattern 1: Fixed-size Sliding Window

**Used for:** Problems where window size `k` is fixed (e.g., max/min/avg in every window).

```java
int left = 0, right = 0;
int n = arr.length;
int k = 3;
int windowSum = 0;
int maxSum = Integer.MIN_VALUE;

while (right < n) {
    // Step 1: expand
    windowSum += arr[right];

    // Step 2: maintain window size = k
    if (right - left + 1 == k) {
        maxSum = Math.max(maxSum, windowSum);
        windowSum -= arr[left];
        left++;
    }

    right++;
}
```

**Examples:**

* Maximum sum subarray of size K
* Average of each subarray of size K

---

## 🧩 Pattern 2: Variable-size Window (Longest / Shortest Subarray with Condition)

**Used for:** Find longest/shortest subarray satisfying some condition (e.g., sum ≤ K, sum == K).

```java
int left = 0, right = 0;
int n = arr.length;
int currentSum = 0;
int maxLen = 0;

while (right < n) {
    // Step 1: expand
    currentSum += arr[right];

    // Step 2: shrink until valid
    while (currentSum > k && left <= right) {
        currentSum -= arr[left];
        left++;
    }

    // process (longest valid subarray)
    maxLen = Math.max(maxLen, right - left + 1);

    right++;
}
```

**Examples:**

* Longest subarray with sum ≤ K
* Smallest subarray with sum ≥ K

---

## 🧩 Pattern 3: Longest Substring with K Unique Characters

**Used for:** Strings where you need to maintain a condition on distinct characters.

```java
Map<Character, Integer> freq = new HashMap<>();
int left = 0, maxLen = 0;

for (int right = 0; right < s.length(); right++) {
    // Step 1: expand
    freq.put(s.charAt(right), freq.getOrDefault(s.charAt(right), 0) + 1);

    // Step 2: shrink until valid
    while (freq.size() > k) {
        char ch = s.charAt(left);
        freq.put(ch, freq.get(ch) - 1);
        if (freq.get(ch) == 0) freq.remove(ch);
        left++;
    }

    maxLen = Math.max(maxLen, right - left + 1);
}
```

**Examples:**

* Longest substring with at most K distinct characters
* Longest substring without repeating characters

---

## 🧩 Pattern 4: Distinct / Duplicate Element Window

**Used for:** Detecting duplicates or maintaining distinctness in a window.

```java
Set<Integer> set = new HashSet<>();
int left = 0, maxLen = 0;

for (int right = 0; right < arr.length; right++) {
    // Step 1: expand until duplicate found
    while (set.contains(arr[right])) {
        set.remove(arr[left]);
        left++;
    }
    set.add(arr[right]);
    maxLen = Math.max(maxLen, right - left + 1);
}
```

**Examples:**

* Longest substring without repeating characters (LeetCode 3)
* Longest subarray with all distinct elements

---

## 🧩 Pattern 5: Count Number of Subarrays (Important Counting Pattern)

**Used for:** Count number of subarrays that satisfy a condition (sum/product/distinct).

### 💡 Trick:

Whenever window `[left, right]` is valid,
➡️ All subarrays ending at `right` are also valid.
So add `(right - left + 1)` to the answer.

```java
int left = 0;
long count = 0;
long product = 1;

for (int right = 0; right < nums.length; right++) {
    // Step 1: expand
    product *= nums[right];

    // Step 2: shrink until valid
    while (product >= k && left <= right) {
        product /= nums[left];
        left++;
    }

    // Step 3: count all valid subarrays ending at right
    count += (right - left + 1);
}
```

**Examples:**

* Subarray Product Less Than K (LeetCode 713)
* Subarrays with At Most K distinct integers
  → `countExactlyK = atMostK(K) - atMostK(K-1)`

---

## 🧩 Pattern 6: Minimum Window Substring (or Minimum Window Subarray)

**Used for:** Find the **smallest window** containing all required elements/characters.

```java
Map<Character, Integer> need = new HashMap<>();
for (char c : t.toCharArray()) need.put(c, need.getOrDefault(c, 0) + 1);

int left = 0, count = 0;
int minLen = Integer.MAX_VALUE;
int start = 0;

for (int right = 0; right < s.length(); right++) {
    char ch = s.charAt(right);
    if (need.containsKey(ch)) {
        need.put(ch, need.get(ch) - 1);
        if (need.get(ch) >= 0) count++;
    }

    // Step 2: shrink to find smaller valid window
    while (count == t.length()) {
        if (right - left + 1 < minLen) {
            minLen = right - left + 1;
            start = left;
        }

        char leftChar = s.charAt(left);
        if (need.containsKey(leftChar)) {
            need.put(leftChar, need.get(leftChar) + 1);
            if (need.get(leftChar) > 0) count--;
        }
        left++;
    }
}

String result = minLen == Integer.MAX_VALUE ? "" : s.substring(start, start + minLen);
```

**Examples:**

* Minimum Window Substring (LeetCode 76)
* Smallest subarray with sum ≥ K

---

## 🧠 Summary Table

| Pattern                         | Type            | Typical Goal               | Key Operation                      |
| ------------------------------- | --------------- | -------------------------- | ---------------------------------- |
| Fixed-size window               | Constant window | Sum/avg/max over K         | Maintain size = K                  |
| Variable-size window            | Expand–shrink   | Longest/shortest window    | `while(condition violated)` shrink |
| Longest substring with K unique | Variable        | Distinct char count = K    | Use frequency map                  |
| Distinct window                 | Variable        | Avoid duplicates           | Use HashSet                        |
| Count subarrays                 | Variable        | Count valid subarrays      | `count += right - left + 1`        |
| Minimum window substring        | Variable        | Find smallest valid window | Shrink from left to minimize       |

---

Would you like me to format this into a **Markdown code block with syntax highlighting and emojis** (GitHub README style — beautiful headings + collapsible sections)?
That way you can directly paste it into your repo’s `/notes/sliding_window.md`.
