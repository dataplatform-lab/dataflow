import ray

ray.init()


@ray.remote(num_cpus=0.1, num_gpus=0.1)
def f():
    return 1


print(ray.get(f.remote()))
