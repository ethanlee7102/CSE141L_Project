def hamming_dist(x, y):
    return bin(x ^ y).count('1')

def merge_words(lines):
    words = []
    cleaned_lines = [line.strip() for line in lines if line.strip()]
    for i in range(0, len(cleaned_lines), 2):
        merged_word = cleaned_lines[i] + cleaned_lines[i + 1]
        words.append(merged_word)
    return words

def find_hamming_dists(words):
    min_distance = float('inf')
    max_distance = 0
    min_pair = None
    max_pair = None

    for i in range(len(words)):
        for j in range(i + 1, len(words)):
            distance = hamming_dist(int(words[i], 2), int(words[j], 2))

            if distance < min_distance:
                min_distance = distance
                min_pair = (i + 1, j + 1)
            if distance > max_distance:
                max_distance = distance
                max_pair = (i + 1, j + 1)

    return min_distance, max_distance, min_pair, max_pair

def read_lines(filename):
    with open(filename, 'r') as file:
        lines = file.readlines()
    return lines

def process_file(input_filename):
    lines = read_lines(input_filename)
    words = merge_words(lines)
    return words

def gather_dists(input_filenames, output_filename):
    results = []
    for input_filename in input_filenames:
        words = process_file(input_filename)
        min_distance, max_distance, min_pair, max_pair = find_hamming_dists(words)
        result = (
            f"{input_filename} min distance: {min_distance} between lines {min_pair}\n"
            f"{input_filename} max distance: {max_distance} between lines {max_pair}\n"
        )
        results.append(result)

    with open(output_filename, 'w') as file:
        for result in results:
            file.write(result)

# Example usage:
input_filenames = [f'test{i}.txt' for i in range(10)]
output_filename = 'prog1_output.txt'

gather_dists(input_filenames, output_filename)